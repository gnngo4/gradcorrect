#!/bin/bash

while getopts g:i:w:j: flag
do
    case "${flag}" in
        g) grad_coeff=${OPTARG};;
        i) in_nifti=${OPTARG};;
        w) out_warp=${OPTARG};;
        j) out_warp_detjac=${OPTARG};;
    esac
done

if [ "`fslval $in_nifti dim4`" -lt  2 ]
then
  in_nifti2=$in_nifti
  crop_volume=No
else
  in_nifti2=/tmp/single_vol.nii.gz
  fslroi $in_nifti ${in_nifti2} 0 1
  crop_volume=Yes
fi

echo "gradient coefficient file (.grad): $grad_coeff";
echo "input (nii.gz): $in_nifti";
echo "output warp field (nii.gz): $out_warp";
echo "output intensity normalizer (nii.gz): $out_warp_detjac"
echo "crop 1st volume: $crop_volume"

echo procGradCorrect \
    -i ${in_nifti2} \
    -g ${grad_coeff} \
    -s /tmp \
    -w ${out_warp} \
    -j ${out_warp_detjac} \
    -F 0.2 -N 150 -I 3

procGradCorrect \
    -i ${in_nifti2} \
    -g ${grad_coeff} \
    -s /tmp \
    -w ${out_warp} \
    -j ${out_warp_detjac} \
    -F 0.2 -N 150 -I 3
