# gradcorrect
CLI tool for obtaining warp and intensity-correction files for gradient non-linearities

## Build docker image
```bash
docker build -t gradcorrect-cli .
```

Run
```bash
docker run gnvngo/gradcorrect -g <grad-coefficient-file> -i <input-nifti> -j <intensity-correction-nifti> -w <gradient-correction-warp-nifti>
```
Outputs: `intensity-correction-nifti` and `gradient-correction-warp-nifti`. These files can be used on the `input-nifti` to correct for gradient non-linearities.

## Building a singularity image from a local docker image

Build singularity image
```bash
# Start a docker registry
docker run -d -p 5000:5000 --restart=always --name registry registry:2
# Build docker image
docker build -t gradcorrect-cli .
# Push local docker container to the registry
docker tag gradcorrect-cli localhost:5000/gradcorrect-cli
docker push localhost:5000/gradcorrect-cli
# Create a singularity image
SINGULARITY_NOHTTPS=1 singularity build gradcorrect-cli.simg docker://localhost:5000/gradcorrect-cli:latest
```
