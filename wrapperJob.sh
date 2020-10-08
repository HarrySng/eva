#!/bin/bash

for run in r1_r1i1p1 r1_r2i1p1 r1_r3i1p1 r1_r4i1p1 r1_r5i1p1 r1_r6i1p1 r1_r7i1p1 r1_r8i1p1 r1_r9i1p1 r1_r10i1p1 r2_r1i1p1 r2_r2i1p1 r2_r3i1p1 r2_r4i1p1 r2_r5i1p1 r2_r6i1p1 r2_r7i1p1 r2_r8i1p1 r2_r9i1p1 r2_r10i1p1 r3_r1i1p1 r3_r2i1p1 r3_r3i1p1 r3_r4i1p1 r3_r5i1p1 r3_r6i1p1 r3_r7i1p1 r3_r8i1p1 r3_r9i1p1 r3_r10i1p1 r4_r1i1p1 r4_r2i1p1 r4_r3i1p1 r4_r4i1p1 r4_r5i1p1 r4_r6i1p1 r4_r7i1p1 r4_r8i1p1 r4_r9i1p1 r4_r10i1p1 r5_r1i1p1 r5_r2i1p1 r5_r3i1p1 r5_r4i1p1 r5_r5i1p1 r5_r6i1p1 r5_r7i1p1 r5_r8i1p1 r5_r9i1p1 r5_r10i1p1; do
	for var in pr tasmax tasmin; do
		echo run
		echo var
		wget http://crd-data-donnees-rdc.ec.gc.ca/CDAS/products/CanLEADv1/CanESM2_ALL-S14FD-MBCn/$run/${var}Adjust_NAM-44i_CCCma-CanESM2_rcp85_${run}_ALL_ECCC-MBCn-S14FD-1981-2010_day_19500101-21001231.nc
		Rscript cleanup.R
		rm -f *.nc
	done
done

