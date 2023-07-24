// Intro to Quantum Software Development
// Lab 1: Setting up the Development Environment
// Copyright 2023 The MITRE Corporation. All Rights Reserved.

namespace Main {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Preparation;
    open Microsoft.Quantum.Diagnostics;

    @Test("QuantumSimulator")
    operation E01Test () : Unit {
        use target = Qubit();
        MessageTest(target);
        AssertQubit(Zero, target);
    }


    operation MessageTest (target: Qubit) : Unit {
        H(target);
        Message(IntAsString((M(target) == One ? 1 | 0)));
    }
}
