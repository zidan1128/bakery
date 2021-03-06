p=`pwd`
for gmx in gmx_*; do
    echo $gmx
    cd $gmx
    for alpha in *; do
        if [ -d "$alpha" ] && [ -f "$alpha/nvt/confout.gro" ]; then
            echo $alpha
            l=`pwd`
            cd $alpha/nvt
            mkdir -p rdf
            cd rdf
            [ ! -f "rdf_C_O.xvg" ] && gmx_mpi rdf -f ../traj_comp.xtc -rmax 1 -o rdf_C_O.xvg -s ../topol.tpr -ref 'name "C*"' -sel 'name "O*"' &> /dev/null
            [ ! -f "rdf_C_N.xvg" ] && gmx_mpi rdf -f ../traj_comp.xtc -rmax 1 -o rdf_C_N.xvg -s ../topol.tpr -ref 'name "C*"' -sel 'name "N*"' &> /dev/null
            cd $l
        fi
    done
    cd $p
done
