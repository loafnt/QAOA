// Intro to Quantum Software Development
// Lab 1: Setting up the Development Environment
// Copyright 2023 The MITRE Corporation. All Rights Reserved.

namespace Main {

    open Microsoft.Quantum.Arithmetic;
	open Microsoft.Quantum.Canon;
	open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Random;

    operation MessageTest (target: Qubit) : Unit {
        H(target);
        Message(BoolAsString(ResultAsBool(M(target))));
    }
}
