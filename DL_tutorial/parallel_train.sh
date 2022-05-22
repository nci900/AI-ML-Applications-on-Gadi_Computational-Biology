#!/bin/bash

# change the path to your own directory
path="/g/data/ik06/stark/NCI_Leopard"
output_path="/g/data/ik06/stark/NCI_Leopard/output"

## To train a single model with two gpus
horovodrun -np 2 --timeline-filename $output_path/unet_timeline.json python3 $path/deep_tf.py -m se_cnn

## To train multiple models
# array=( cnn unet se_cnn )
# for i in "${array[@]}"
# do
# 	horovodrun -np 2 --timeline-filename $output_path/"$i"_timeline.json python3 "$path"/deep_tf.py -m $i
# done

## To train a single model with two nodes which contain 8 gpus
## you need to modify the name ("gadi-gpu-v100-0xxx")to assigned node
## To check the assigned node name "qstat -fx <jobid>"  
#horovodrun -np 8 -H gadi-gpu-v100-0018:4,gadi-gpu-v100-0114:4 --verbose --start-timeout 300 --timeline-filename $output_path/unet_timeline.json python3 $path/deep_tf.py -m se_cnn