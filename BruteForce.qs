//bnewmantkd's implementation of the Brute Force Test of the Travelling Salesman Problem

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

    operation GeneratePermutations(N : Int) : Int[][] {
        mutable result = [];
        mutable current = [0,size=N];
        for i in 0..N-1 {
            set current w/= i <- i;
        }
        set (current, result) = GeneratePermutationsHelper(N, current, 0, result);
        return result;
    }

    operation GeneratePermutationsHelper(N : Int, current : Int[], pos : Int, result : Int[][]) : (Int[], Int[][]) {
        mutable index = 0;
        mutable mutCurrent = current;
        mutable mutResult = result;
        if (pos == N) {
            set mutResult += [mutCurrent];
        }
        else {
            for i in pos..N-1 {
                set index = mutCurrent[pos];
                set mutCurrent w/= pos <- mutCurrent[i];
                set mutCurrent w/= i <- index;
                set (mutCurrent, mutResult) = GeneratePermutationsHelper(N, mutCurrent, pos + 1, mutResult);
                set index = mutCurrent[pos];
                set mutCurrent w/= pos <- mutCurrent[i];
                set mutCurrent w/= i <- index;
            }
        }
        return (mutCurrent, mutResult);
    }

    operation BruteForce (
		x : Int[],
		y : Int[],
		N : Int
	) : (Double, Int[]) {
		//Variable declarations:
        //Needs Q# list of permutations of nodes:
        mutable prospectiveCycles = GeneratePermutations(N);
        mutable bestDist = PowD(10.0, 10.0);
        mutable bestOrder = [0,size=0];
        //Iterables:
        //Needs to be implemented with Q# 2D Int arrays
        for i in prospectiveCycles {
            mutable distance = 0.;
            mutable pre_j = 0;
            for j in i {
                set distance += PowD((PowD(IntAsDouble(AbsI(x[j]-x[pre_j])), 2.0)+PowD(IntAsDouble(AbsI(y[j]-y[pre_j])), 2.0)), 0.5);
                set pre_j = j;
            }
            set distance += PowD((PowD(IntAsDouble(AbsI(x[0]-x[pre_j])), 2.0)+PowD(IntAsDouble(AbsI(y[0]-y[pre_j])), 2.0)), 0.5);
            if (distance < bestDist) {
                set bestOrder = i;
                set bestDist = distance;
                //Message("Order = " + IntAsString(order) + " Distance = " + DoubleAsString(distance));
            }
        }

        //Final return statement:
        return (bestDist, bestOrder);
	}
}
