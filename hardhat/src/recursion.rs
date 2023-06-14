use std ::{collections::HashMap, env::current_dir, time::Instant, fs::File, io:: BufReader};

use nova_scotia::{
    circom::reader::load_r1cs, create_public_params, create_recursive_circuit, FileLocation, F1,
    G2, S1, S2,
};
use nova_snark::{traits::Group, CompressedSNARK};
use serde_json::{Value, from_reader};
use ff::PrimeField;

pub fn main() {
    let integration_count = 5;
    //  // `unwrap` returns a `panic` when it receives a `None`.
    let root = current_dir().unwrap();
    println!("Root: {:?}", root);
    let circuit_file = root.join("circuits/build/recursion_test.r1cs");
    let r1cs = load_r1cs(&FileLocation::PathBuf(circuit_file));
    let witness_generator_wasm = root.join("circuits/build/recursion_test_js/recursion_test.wasm");
    println!("witness_generator_wasm: ");
    let json_filename = root.join("src/input.json");
    let json_file = File::open(json_filename).unwrap();
    let json_reader = BufReader::new(json_file);
    let json: HashMap<String, Value> = from_reader(json_reader).unwrap();

    println!("json: {:?}", json);

    let mut private_inputs = Vec::new();
    for _i in 0..integration_count {
        private_inputs.push(json.clone());
    }
    println!("private_inputs generated ");
    // //from_str_vartime ->Interpret a string of numbers as a (congruent) prime field element. Does not accept unnecessary leading zeroes or a blank string.
    // // these input go inside the first iteration of the circuit folding
    let start_public_input = vec![F1::from(10), F1::from(10)];

    println!("start_public_input: {:?}", start_public_input);


    // // // 
    let pp = create_public_params(r1cs.clone());
    println!("Number of constrains : {}", pp.num_constraints().0);

    println!("Creating recursive SNARK");
    let start = Instant::now();
    let recursive_snark = create_recursive_circuit(
        FileLocation::PathBuf(witness_generator_wasm),
        r1cs,
        private_inputs,
        start_public_input.clone(),
        &pp
    )
    .unwrap();

    println!("Recursive circuit created in {:?}", start.elapsed());

    println!("Verifying recursive proof");

    let z0_secondary = vec![<G2 as Group>::Scalar::zero()];

    println!("z0_secondary: {:?}", z0_secondary);

    let start = Instant::now();
    let result = recursive_snark.verify(
        &pp,
        integration_count,
        start_public_input.clone(),
        z0_secondary.clone(),
    );

    println!("Recursive proof verified in {:?}", start.elapsed());

    assert!(result.is_ok());

    // compressed snark
    let start = Instant::now();
    let (pk, vk) = CompressedSNARK::<_, _, _, _, S1, S2>::setup(&pp).unwrap();
    let res = CompressedSNARK::<_,_,_,_, S1, S2>::prove(&pp, &pk, &recursive_snark);
    println!("Compressed proof created in {:?}", start.elapsed());
    assert!(res.is_ok());

    let compressed_snark = res.unwrap();

    //verify the compressed snark
    let res = compressed_snark.verify(&vk, integration_count, start_public_input.clone(), z0_secondary,);
    assert!(res.is_ok());
}
