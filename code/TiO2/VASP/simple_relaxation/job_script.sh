#!/bin/bash
#SBATCH --time=0:05:00
#SBATCH --nodes=1                  
#SBATCH --ntasks-per-node=1       
#SBATCH --mem=200               # Memory per node (in MB). Default 200M per CPU
#SBATCH --job-name="TiO2"
#SBATCH --output=a%j.out          
#SBATCH --partition=matrix        
#SBATCH --constraint=avx
#SBATCH --exclude=str957-bl0-01,str957-bl0-02,str957-bl0-03,str957-bl0-04,str957-bl0-05,str957-bl0-15,str957-bl0-16,str957-bl0-17,str957-bl0-18,str957-bl0-19,str957-bl0-20

mkdir output
cp POSCAR output/
cp INCAR output/
cp POTCAR output/
cp KPOINTS output/
cp ENCUT_relaxation.sh output/

cd output
chmod 777 ENCUT_relaxation.sh
./ENCUT_relaxation.sh
