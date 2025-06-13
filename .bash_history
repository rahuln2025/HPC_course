nano job.script
#1734551477
qsub job.script
#1734551495
qstat
#1734551498
ls
#1734551507
qstat
#1734551526
less job.script 
#1734551537
ls
#1734551546
qstat
#1734551547
ls
#1734551559
nano job.script
#1734551617
ls
#1734551629
qsub job.script
#1734551632
qstat
#1734551687
ls
#1734551693
cd ..
#1734551694
ls
#1734551705
cd HPC_CMS_202425/
#1734551706
ls
#1734551715
cd ..
#1734551717
ls 
#1734551721
cd PVL_202425/
#1734551723
ls
#1734551733
less job.script
#1734551834
nano job.script
#1734551866
qsub job.script
#1734551873
less hpc_24a_ex01.out
#1734551882
less hpc_24a_ex01.err
#1734551908
qstat
#1734551915
mpiexec -n 2 PVL2_2
#1734552063
qstat
#1734552064
ls
#1734552072
less PVL2_output.out 
#1734552097
nano job.script
#1734552115
mpiexec -n 2 PVL2_2
#1734552141
qsub job.script
#1734552350
qstat
#1734552353
ls
#1734552362
less PVL2_output.out 
#1734552382
nano job.script
#1734552442
qsub -I -q teachinq
#1734552445
qsub -I -q teachingq
#1734552595
pwd
#1734552604
nano job.script
#1734552629
qsub job.script
#1734552636
qstat
#1734552700
ls
#1734552706
less PVL2_output.out
#1734552725
qsub -I -q teachingq
#1734552825
ls
#1734552830
less PVL2_2
#1734552839
less PVL2.C
#1734553006
nano PVL2.C
#1734553077
mpicc -o PVL2_3 PVL2.C
#1734553085
mpiexec -n 2 PVL2_3
#1734553153
less PVL2_output.err
#1734553184
nano job.script
#1734553249
qsub job.script
#1734553252
qstat
#1734553302
ls
#1734553306
qstat
#1734553350
ls
#1734553358
less PVL2_output.out
#1734553369
less PVL2_output.err
#1734553470
less job.script
#1734553502
nano job.script
#1734553567
qsub job.script
#1734553641
qstat
#1734553643
ls
#1734553653
less PVL2_output.out
#1734553689
nano job.script
#1734553708
cp PVL2_2 ~/
#1734553709
ls
#1734553710
cd ..
#1734553711
ls
#1734553718
cd PVL_202425/
#1734553725
qsub job.script
#1734553740
qstat
#1734553795
ls
#1734553803
less PVL2_output.out
#1734553858
nano job.script 
#1734553876
qsub job.script
#1734553918
qstat
#1734553968
ls
#1734553974
less PVL2_output.out
#1734553986
nano job.script
#1734554071
less PVL2_output.err
#1734554086
less job.script
#1734554126
qsub job.script
#1734554418
ls
#1734554429
less PVL_output.out
#1734554436
less PVL2_output.out
#1734554456
nano job.script
#1734554495
less job.script
#1734554531
qsub job.script
#1734554656
qstat
#1734554660
ls
#1734554666
less PVL2_output.out
#1734554690
less PVL2_output.err
#1748499562
ls
#1748500174
git init
#1748500188
ls
#1748500196
git status
#1748500205
git add .
#1748500213
git status
#1748500232
git commit -m Â'adding all old files from cluster'
#1748500238
git init
#1748500244
git status
#1748500305
git remote add origin https://github.com/rahuln2025/HPC_course.git
#1748500313
git push -u origin master
#1748500582
git status
ls
pwd
cd HPC_CMS_202425/
ls
pwd
#1749240883
ls
ls
pwd
pwd
ls
cd HPC_CMS
ls
cd ..
pwd
cd HPC_CMS_Home/
ls
pwd
pwd
ls
cd PVL_202425/
ls
cd PVL2
cd PVL2_3
ls -al
less job.script 
cd ..
less .nanorc
ls -al
nano .bashrc
nano
clear
ls /usr/share/nano
less ~/.nanorc
cd ~
ls
cat ~/.nanorc
ls -l
pwd
ls
pwd
ls
mkdir HPC_CMS_2025
cd HPC_CMS
cd ..
cd HPC_CMS_2025
git status
cd ..
cd PBS_O_WORKDIR
cd $HOME/HPC_CMS_2025
echo "Run on login node for testing"
export OMP_NUM_THREADS=4
time ./hello-openmp 
time ./hello-openmp 
time ./hello-openmp
qsub hpc24a_ex02_job.script 
qsub hpc24a_ex02_job.script 
export OMP_NUM_THREADS=4
time ./ex02a 
qsub hpc24a_ex02a_job.script 
qsub hpc24a_ex02a_job.script
qsub hpc24a_ex02a_job.script
pwd
git status
git add .gitignore
cd ..
git add .gitignore 
git commit -m 'gitignore'
git status
git add README.md 
git commit -m 'Updated instructions for running OpenMP scripts"
git commit -m 'Updated instructions for running OpenMP scripts'
git status
cd HPC_CMS_2025
ls
git status
git add .
git commit -m 'Ex02a'
git push
g++ -o ex02d hpc24a_ex02d.cpp -O0 -fopenmp
ls
qsub hpc24a_ex02d_job.script 
g++ -o ex02d hpc24a_ex02d.cpp -O0 -fopenmp
qsub hpc24a_ex02d_job.script 
g++ -o ex02d hpc24a_ex02d.cpp -O0 -fopenmp
qsub hpc24a_ex02d_job.script 
g++ -o ex02d hpc24a_ex02d.cpp -O0 -fopenmp
qsub hpc24a_ex02d_job.script 
qsub hpc24a_ex02d_job.script 
g++ -o ex02d hpc24a_ex02d.cpp -O0 -fopenmp
qsub hpc24a_ex02d_job.script 
g++ -o ex02d hpc24a_ex02d.cpp -O0 -fopenmp
qsub hpc24a_ex02d_job.script 
g++ -o ex03a hpc24a_ex03a.cpp -O0 -fopenmp
g++ -o ex03a hpc24a_ex03a.cpp -O0 -fopenmp
ls
qsub hpc24a_ex03a_job.script 
g++ -o ex03a hpc24a_ex03a.cpp -O0 -fopenmp
qsub hpc24a_ex03a_job.script 
g++ -o ex03a hpc24a_ex03a.cpp -O0 -fopenmp
pwd
ls
nano instructions.txt
touch README.md
git status
git add README.md 
git commit -m 'Update README for instructions'
git push
cd HPC_CMS_2025
ls
echo "first compile program"
module load openmpi/gcc/11.4.0/4.1.6
module load python/gcc/11.4.0/3.11.7
g++ -fopenmp hpc24a_ex02.C -o hpc24a_ex02.out
g++ -fopenmp hpc24a_ex02.C -o hpc24a_ex02.out
gcc -fopenmp hpc24a_ex02.C -o hpc24a_ex02.out
ls
g++ -o hello-openmp hpc24a_ex02.C -O0 -fopenmp
g++ -o hello-openmp hpc24a_ex02.cpp -O0 -fopenmp
g++ -o hello-openmp hpc24a_ex02.cpp -O0 -fopenmp
g++ -o hello-openmp hpc24a_ex02.cpp -O0 -fopenmp
g++ -o hello-openmp hpc24a_ex02.cpp -O0 -fopenmp
touch jobscript_hpc24a_ex02.sh
g++ -o hello-openmp hpc24a_ex02.cpp -O0 -fopenmp
g++ -o ex02a hpc24a_ex02a.cpp -O0 -fopenmp
g++ -o ex03a hpc24a_ex03a.cpp -O0 -fopenmp
g++ -o ex03a hpc24a_ex03a.cpp -O0 -fopenmp
qsub hpc24a_ex03a_job.script 
g++ -o ex03a hpc24a_ex03a.cpp -O0 -fopenmp
qsub hpc24a_ex03a_job.script 
g++ -o ex03d hpc24a_ex03d.cpp -O0 -fopenmp
qsub hpc24a_ex03d_job.script 
qsub hpc24a_ex03d_job.script 
g++ -o ex03d hpc24a_ex03d.cpp -O0 -fopenmp
qsub hpc24a_ex03d_job.script 
qsub hpc24a_ex03d_job.script 
g++ -o ex03a hpc24a_ex03a.cpp -O0 -fopenmp
qsub hpc24a_ex03a_job.script 
g++ -o ex03d hpc24a_ex03d.cpp -O0 -fopenmp
qsub hpc24a_ex03d_job.script 
git status
git status
git add .
git commit -m 'hpc24a exercise codes and results'
git push
cd ..
ls
mkdir VOID
mv -R HPC_CMS HPC_CMS_202425 HPC_CMS_Home ./VOID/
mv 
mv HPC_CMS HPC_CMS_202425 HPC_CMS_Home ./VOID/
ls
cd PVL_202425/
ls
less job.script 
cd ..
ls
mv PVL2_2 ./VOID/
ls
ls ./PVL_202425/
ls
mv PVL_202425/ ./VOID
ls
git status
git status
git add .
git commit -m 'Cleaned old stuff'
git push
git status
cd HPC_CMS_2025/
g++ -o ex04a hpc24b_ex04.cpp -O0 -fopenmp
ls
qsub hpc24a_ex03d_job.script 
qsub -n 1 hpc24b_ex04a_job.script
N=1 qsub hpc24b_ex04a_job.script 
N=1 qsub hpc24b_ex04a_job.script 3
N=1 qsub hpc24b_ex04a_job.script
N=8 qsub hpc24b_ex04a_job.script
N=8 qsub hpc24b_ex04a_job.script
qsub hpc24b_ex04a_job.script
qsub hpc24b_ex04a_job.script
qsub hpc24b_ex04a_job.script
qsub hpc24b_ex04a_job.script
ls
module available
clear
ls
cd HPC_CMS_2025/
g++ -o ex04b hpc24b_ex04.cpp -O0 -fopenmp
g++ -o ex04b hpc24b_ex04.cpp -O0 -fopenmp
g++ -o ex04b hpc24b_ex04.cpp -O0 -fopenmp
g++ -o ex04b hpc24b_ex04.cpp -O0 -fopenmp
g++ -o ex04b hpc24b_ex04.cpp -O0 -fopenmp
g++ -o ex04b hpc24b_ex04.cpp -O0 -fopenmp
g++ -o ex04b hpc24b_ex04.cpp -O0 -fopenmp
ls
qsub hpc24b_ex04b_job.script 
git status
git add .
git commit -m 'Ex 04 a b'
g++ -o ex05a hpc24b_ex05a.cpp -O0 -fopenmp
ls
qsub hpc24b_ex05a_job.script 
qsub hpc24b_ex05a_job.script 
qsub hpc24b_ex05a_job.script 
g++ -o ex05c hpc24b_ex05c.cpp -O0 -fopenmp
g++ -o ex05c hpc24b_ex05c.cpp -O0 -fopenmp
g++ -o ex05c hpc24b_ex05c.cpp -O0 -fopenmp
g++ -o ex05c hpc24b_ex05c.cpp -O0 -fopenmp
g++ -o ex05c hpc24b_ex05c.cpp -O0 -fopenmp
g++ -o ex05c hpc24b_ex05c.cpp -O0 -fopenmp
g++ -o ex05c hpc24b_ex05c.cpp -O0 -fopenmp
qsub hpc24b_ex05a_job.script
g++ -o ex05a hpc24b_ex05a.cpp -O0 -fopenmp
qsub hpc24b_ex05a_job.script
g++ -o ex05c hpc24b_ex05c.cpp -O0 -fopenmp
ls
qsub hpc24b_ex05c_job.script
top
qsub hpc24b_ex05c_job.script
top
g++ -o ex05c hpc24b_ex05c.cpp -O0 -fopenmp
qsub hpc24b_ex05c_job.script
g++ -o ex05c hpc24b_ex05c.cpp -O0 -fopenmp
qsub hpc24b_ex05c_job.script
g++ -o ex05c hpc24b_ex05c.cpp -O0 -fopenmp
qsub hpc24b_ex05c_job.script
git status
git add .
git commit -m 'Ex 05 Monte Carlo & Matrix Multipilication'
git push
cd ..
git status
git add .
git commit -m 'Updated Readme for matrix handling'
git push
ls
cd HPC_CMS_2025/
ls
module load gdb
module spider gdb
module load gdb/python/gcc/11.3.0/3.10.12
module load gdb/python/gcc/11.3.0/3.10.12/13.1
module load gdb/python/gcc/11.4.0/3.11.7/0.14.1
gcc -g -O hpc24b_ex04.cpp -o ex04_gdb
g++ -g -O hpc24b_ex04.cpp -o ex04_gdb
g++ -o ex04_gdb hpc24b_ex04.cpp -O0 -fopenmp
ls
gdb ex04_gdb
g++ -o ex04_gdb hpc24b_ex04.cpp -g -O0 -fopenmp
gdb ex04_gdb
g++ -pg -O hpc24b_ex04.cpp -o ex04_gprof
g++ -pg -O hpc24b_ex04.cpp -o ex04_gprof -fopenmp
ls
gprof ex04_gprof 
g++ -o ex04_gdb hpc24b_ex04.cpp -pg -O0 -fopenmp
gprof ex04_gprof 
g++ -o ex04_gdb hpc24b_ex04.cpp -pg -O0
g++ -o ex04_gprof hpc24b_ex04.cpp -pg -O0 -fopenmp
gprof ex04_gprof 
ls
g++ -o ex04_gprof hpc24b_ex04.cpp -pg -O0
g++ -o ex04_gprof hpc24b_ex04.cpp -pg -O0 -fopenmp
ls
git status
~/sync/mpich-1.2.5.2/man/man3
map -l MPI_Isend.3
man -l MPI_Isend.
~/sync/
~
ls
cd /sync
cd HPC_CMS_2025/
ls
export OMP_NUM_THREADS=4
time ./add_vectors_openMP 
g++ add_vectors_openMP add_vectors_openMP.cpp -O0 -fopenmp
g++ add_vectors_openMP add_vectors_openMP.cpp -O0 -fopenmp
g++ add_vectors_openMP add_vectors_openMP.cpp -O0 -fopenmp
g++ add_vectors_openMP add_vectors_openMP.cpp -O0 -fopenmp
g++ add_vectors_openMP add_vectors_openMP.cpp -O0 -fopenmp
g++ add_vectors_openMP add_vectors_openMP.cpp -O0 -fopenmp
rm add_vectors_openMP
ls
g++ add_vectors_openMP add_vectors_openMP.cpp -O0 -fopenmp
g++ -o add_vectors_openMP add_vectors_openMP.cpp -O0 -fopenmp
ls
time ./add_vectors_openMP
git status
git add ../README.md ./add_vectors_openMP.cpp 
git commit -m 'Simple function for vector addition'
git push
module load mpic++
module load openmpi/gcc/11.4.0
mpicc -o ex07 -i hpc24c_ex07.cpp 
mpicc -o ex07 hpc24c_ex07.cpp 
ls
mpic++ -o ex07 hpc24c_ex07.cpp 
ls
mpiexec ex07
qsub hpc24c_ex07_job.script 
qsub hpc24c_ex07_job.script 
mpic++ -o ex07 hpc24c_ex07.cpp 
qsub hpc24c_ex07_job.script 
mpic++ -o ex07 hpc24c_ex07.cpp 
qsub hpc24c_ex07_job.script 
mpic++ -o ex07 hpc24c_ex07.cpp 
qsub hpc24c_ex07_job.script 
mpic++ -o ex07 hpc24c_ex07.cpp 
qsub hpc24c_ex07_job.script 
mpic++ -o ex07 hpc24c_ex07.cpp 
qsub hpc24c_ex07_job.script 
qsub hpc24c_ex07_job.script 
mpic++ -o ex07 hpc24c_ex07.cpp 
qsub hpc24c_ex07_job.script 
git status
git add .
git commit -m "First MPI program"
git push
git status
git add ../README.md 
git commit -m 'Updated README for MPI program execution"

git commit -m 'Updated README for MPI program execution'
git push
mpic++ -o ex08 hpc24c_ex08.cpp 
mpic++ -o ex08 hpc24c_ex08.cpp 
mpic++ -o ex08 hpc24c_ex08.cpp 
ls
qsub hpc24c_ex08_job.script 
mpic++ -o ex08 hpc24c_ex08.cpp 
qsub hpc24c_ex08_job.script 
top
mpic++ -o ex08 hpc24c_ex08.cpp 
qsub hpc24c_ex08_job.script 
qsub hpc24c_ex08_job.script 
mpic++ -o ex08 hpc24c_ex08.cpp 
qsub hpc24c_ex08_job.script 
mpic++ -o ex08 hpc24c_ex08.cpp 
mpic++ -o ex08 hpc24c_ex08.cpp 
mpic++ -o ex08 hpc24c_ex08.cpp 
qsub hpc24c_ex08_job.script 
qsub hpc24c_ex08_job.script 
mpic++ -o ex08 hpc24c_ex08.cpp 
qsub hpc24c_ex08_job.script 
mpiexec -n 4  ./ex08
mpic++ -o ex08 hpc24c_ex08.cpp 
mpiexec -n 4  ./ex08
mpic++ -o ex08 hpc24c_ex08.cpp 
mpiexec -n 4  ./ex08
mpiexec -n 4  ./ex08
mpic++ -o ex08 hpc24c_ex08.cpp 
mpiexec -n 4  ./ex08
mpic++ -o ex08 hpc24c_ex08.cpp 
mpiexec -n 4  ./ex08
mpic++ -o ex08 hpc24c_ex08.cpp 
mpiexec -n 4  ./ex08
mpic++ -o ex08 hpc24c_ex08.cpp 
mpiexec -n 4  ./ex08
mpic++ -o ex08 hpc24c_ex08.cpp 
mpiexec -n 4  ./ex08
mpic++ -o ex08 hpc24c_ex08.cpp 
mpiexec -n 4  ./ex08
cd HPC_CMS_2025/
g++ -o add_vectors_openMP.cpp -O0 -fopenmp
g++ -o add_vectors_openMP add_vectors_openMP.cpp -O0 -fopenmp
g++ -o add_vectors_openMP add_vectors_openMP.cpp -O0 -fopenmp
g++ -o add_vectors_openMP add_vectors_openMP.cpp -O0 -fopenmp
ls
ls
cd HPC_CMS_2025/
ls
g++ -o sir_model sir_model.cpp -O0 -fopenmp
g++ -o sir_model sir_model.cpp -O0 -fopenmp
ls
time ./sir_model 
g++ -o sir_model sir_model.cpp -O0 -fopenmp
g++ -o sir_model sir_model.cpp -O0 -fopenmp
time ./sir_model 
g++ -o sir_model sir_model.cpp -O0 -fopenmp
time ./sir_model 
module load python
module spider python
module load gdb/python/gcc/11.3.0/3.10.12/13.1
module spider python
module load gdb/python/gcc/11.3.0/3.10.12/13.1
module spider  gdb/python/gcc/11.3.0/3.10.12/13.1
module load gdb/python/gcc/11.3.0/3.10.12/13.1
module load python
module load python/gcc/11.4.0
python3
