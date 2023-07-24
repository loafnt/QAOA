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
        messageTest(target);
        AssertQubit(Zero, target);
        Reset(target);
    }
    
    //Hello World equivalent
    operation messageTest (target: Qubit) : Unit {
        H(target);
        Message(IntAsString((M(target) == One ? 1 | 0)));
        DumpMachine();
    }


    //QAOA circuit loop
    operation QAOA (measure:Bool[], p:Int, beta:Double, gamma:Double) : Bool[]{

        //input qubits
        use register = Qubit[Length(measure)];

        //prepare qubits by creating uniform superposition
        ApplyToEach(H, register);

        //repeat cost and mixer steps p times
        for i in 1..p{
            costHamiltonian(register, gamma);
            mixerHamiltonian(register, beta);
        }

        //Read the results as a boolean array (true==1, false==0)
        mutable res = new Bool[Length(register)];
        for i in 0..Length(register){
            set res w/= i <- (M(register[i]) == One ? true | false);
        }

        //return the results
        return res;
     }

     operation costHamiltonian (register:Qubit[], gamma:Double):Unit{
        //Assuning lenght of register is 5

        //I aint commenting this sheet
        let (q0, q1, q2, q3, q4, q5)= (register[0], register[1], register[2], register[3], register[4], register[5]);
        CNOT(q1, q0);
        Rz(gamma, q0);
        CNOT(q1, q0);
        CNOT(q2, q0);
        CNOT(q2, q0);
        Rz(gamma, q0);
        CNOT(q2, q0);
        CNOT(q2, q1);
        CNOT(q3, q0);
        Rz(5.*gamma, q0);
        Rz(2.*gamma, q1);
        CNOT(q2, q1);
        CNOT(q3, q0);
        CNOT(q3, q1);
        CNOT(q4, q0);
        Rz(5.*gamma, q0);
        Rz(gamma, q1);
        CNOT(q3, q1);
        CNOT(q4, q0);
        CNOT(q3, q2);
        CNOT(q4, q1);
        Rz(3.*gamma, q1);
        Rz(5.*gamma, q2);
        CNOT(q3, q2);
        CNOT(q4, q1);
        CNOT(q4, q2);
        Rz(gamma, q2);
        CNOT(q4, q2);
        CNOT(q4, q3);
        Rz(5.*gamma, q3);
        CNOT(q4, q3);
     }

     operation mixerHamiltonian (register:Qubit[], beta:Double):Unit{
         //uhhh yeah you just like do this
         ApplyToEach(Rx(2.*beta, _), register);
     }
}
