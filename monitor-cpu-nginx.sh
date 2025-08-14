#/bin/bash
 docker inspect nginx18 | grep Cpu
 docker inspect --format '{{json .HostConfig.Memory}}' nginx18 | numfmt --to=iec

