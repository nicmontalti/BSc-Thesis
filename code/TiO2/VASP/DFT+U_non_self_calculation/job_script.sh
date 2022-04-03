#!/bin/bash
#SBATCH --time=0:05:00
#SBATCH --nodes=1                  
#SBATCH --ntasks-per-node=1       
#SBATCH --mem=400               # Memory per node (in MB). Default 200M per CPU
#SBATCH --job-name="TiO2"
#SBATCH --output=a%j.out          
#SBATCH --partition=matrix        
#SBATCH --constraint=avx
#SBATCH --exclude=str957-bl0-01,str957-bl0-02,str957-bl0-03,str957-bl0-04,str957-bl0-05,str957-bl0-15,str957-bl0-16,str957-bl0-17,str957-bl0-18,str957-bl0-19,str957-bl0-20

source /home/software/materia/intel_lib/setvars.sh --force
export I_MPI_PMI_LIBRARY=/usr/lib/x86_64-linux-gnu/libpmi2.so.0
export I_MPI_FABRICS=shm:dapl
#------------------------------------------------------------------------------------
# position of VASP executable
EXEC="/home/PERSONALE/lorenzo.varrassi3/VASPInstallation_2021-10-7/vasp.6.2.0_OmarMakefile_CompiledByMe/bin/vasp_std"
VASP="srun -n $SLURM_NTASKS $EXEC"
#------------------------------------------------------------------------------------

cp KPATH.in KPOINTS
mkdir output
cp * output/
cd output
$VASP
