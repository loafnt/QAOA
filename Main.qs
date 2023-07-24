// Intro to Quantum Software Development
// Lab 1: Setting up the Development Environment
// Copyright 2023 The MITRE Corporation. All Rights Reserved.

namespace Main {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation MessageTest (target: Qubit) : Unit {
        H(target);
        Message(M(target));
    }
}
