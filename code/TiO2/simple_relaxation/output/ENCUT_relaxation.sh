#! /bin/bash
source /home/software/materia/intel_lib/setvars.sh --force
export I_MPI_PMI_LIBRARY=/usr/lib/x86_64-linux-gnu/libpmi2.so.0
export I_MPI_FABRICS=shm:dapl
#------------------------------------------------------------------------------------
# position of VASP executable
EXEC="/home/PERSONALE/lorenzo.varrassi3/VASPInstallation_2021-10-7/vasp.6.2.0_OmarMakefile_CompiledByMe/bin/vasp_std"
VASP="srun -n $SLURM_NTASKS $EXEC"
#------------------------------------------------------------------------------------

rm WAVECAR SUMMARY.dia
for i in 420 440 460 480 500; do
cat >INCAR <<!
SYSTEM=TiO2

ISTART = 0      # start from scratch
ICHARGE = 2     # charge from superposition of individual charges
ISMEAR = 0      # gaussian
SIGMA = 0.01

LOUT = 10       # DOSCAR and PROCAR
LCHARGE.false
LWAVE.false

# lattice relaxation
ENCUT = $i     # 1.3*POTCAR
EDIFF = 0.1E-04
EDIFFG = -0.01  # force to stop the loop
IBRION = 1      # perform the relaxation
ISIF = 0        # modify positions, don't calculate stress tensor
NSW = 15        # maximum number of iterations
!
echo "a= $i" ;  $VASP
E=`awk '/F=/ {print $0}' OSZICAR` ; echo $i $E  >>SUMMARY.dia
done
cat SUMMARY.dia
