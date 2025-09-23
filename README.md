# pcb2gcode-docker

Docker image to run `pcb2gcode` without the need to install all of it's dependencies at their correct versions.

```bash
docker run --rm -i -t -v ".:/data" ptodorov/pcb2gcode:latest --version
```

### [Tutorial on how to use this with KiCAD](https://peterprototypes.com/blog/pcb2gcode/)