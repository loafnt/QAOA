namespace tspQs {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Preparation;
    open Microsoft.Quantum.Diagnostics;

    @EntryPoint()
    operation helloWorld() : Unit {
        Message("Hello World!");
    }

    operation driverHamiltonian(x: Qubit[], t: Double) : Unit {
        ApplyToEach(Rx( -2.0 * t, _), x);
    }

    operation instanceHamiltonian(z: Qubit[], t: Double, h: Double[], J: Double[]) : Unit {
        use ancilla = Qubit[1];
        for i in 0..5 {
            Rz(2.0*t*h[i], z[i]);
        }
        for i in 0..5 {
            for j in i + 1..5 {
                CNOT(z[i], ancilla[0]);
                CNOT(z[j], ancilla[0]);
                Rz(2.0 *t*J[6*i + j], ancilla[0]);
                CNOT(z[i], ancilla[0]);
                CNOT(z[j], ancilla[0]);
            }
        }
    }

    operation QAOA(weights: Double[], penalty: Double, tx: Double[], tz: Double[], p:Int) : Bool[] {
        mutable J = new Double[36];
        mutable h = new Double[6];
        for i in 0..5 {
            set h w/=i <- 4.0*penalty - .5*weights[i];
        }

        for i in 0..35 {
            set J w/= i <- 2.0*penalty;
        }

        set J w/=2 <- penalty;
        set J w/=9 <- penalty;
        set J w/=29 <- penalty;

        mutable r = [false, size = 6];
        use x = Qubit[6];

        ApplyToEach(H, x);
        ApplyToEach(instanceHamiltonian(x, _, h, J), tz);
        ApplyToEach(driverHamiltonian(x, _), tx);

        return r;

    }
}