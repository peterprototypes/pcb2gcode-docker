# pcb2gcode-docker

Use this Docker image to run `pcb2gcode` without the need to install it and all of it's dependencies at their correct versions on your system.

```bash
docker run --rm -i -t -v ".:/data" ptodorov/pcb2gcode:latest --version
```