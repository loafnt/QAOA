// QSD Lab 6 Q# Tests
// Copyright 2023 The MITRE Corporation. All Rights Reserved.
//
// DO NOT MODIFY THIS FILE.


namespace MITRE.QSD.BFTSP {

    open Microsoft.Quantum.Arithmetic;
	open Microsoft.Quantum.Canon;
	open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Random;


    @Test("QuantumSimulator")
    operation BruteForceTest () : Unit {
        //Running, testing, and printing operation with 6 nodes / cities:
        let xTest = [6, 1, 6, 2, 14, 9];
        let yTest = [4, 5, 2, 11, 8, 3];
        let (Best_distance, Best_order) = BruteForce(xTest, yTest, Length(xTest));
        Message(DoubleAsString(Best_distance));
        let cycles = GeneratePermutations(Length(xTest));
        mutable strOrder = "[";
        for i in 0..Length(Best_order)-2 {
            set strOrder += IntAsString(Best_order[i]);
            set strOrder += ", ";
        }
        set strOrder += IntAsString(Best_order[Length(Best_order)-1]);
        set strOrder += "]";
        Message(strOrder);
    }
}