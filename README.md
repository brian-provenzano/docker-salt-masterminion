## Docker SaltStack Learning Lab
Creates a simple master + three salt minions (2 ubuntu and 1 centos) for use in learning or labbing salt locally.  A nice alternative to using vagrant that is much lighter and quicker to deal with.  The master is set to auto accept all minion keys in the `master` config to ease setup and usage.  I have also enabled `cli_summary` as well. Volumes are persisted as long as you do NOT run `make destroy` (although your states and pillar files are NEVER deleted).  If you wish to stop for the day and pick up later, just run `make stop` or `make halt` which will stop the containers.  To restart again run `make start`.

See the Usage instructions below for more step by step details on usage.

## Prerequsites
- Docker and Docker Compose installed.
  - Linux: go to docker.com and setup the repos for your distro and install docker and docker-compose
  - Mac: install Docker for Mac - includes docker, docker compose and Kubernetes all-in-one.

### Usage
Uses a Makefile in order to simplify setup/management and running of the containers.  Please see the Makefile for all the options available.

1. Clone this repo and cd to the root.
2. Run `make setup` to create the initial salt subdirectories for your lab salt/(states, pillar, etc, cache...).  Only run this once - any subdirs of `salt` are not included via the `.gitignore`
3. Run `make build` to build all the requisite images.
   - If you would like to use Alpine Linux for the master you can modify the `docker-compose.yaml` to use it instead.  I am currently using Ubuntu for simplicity in leveraging the salt command bash completions.
4. Run `make up` to bring up all the containers.  The containers ENTRYPOINT are set to run salt in `debug` mode to make it easier to debug any issues or view the configuration/setup and running of the master/minions.
5.  Switch to another terminal (same directory) - run `make cli-master`.  This will drop you into the salt master.  Run `salt-key -L` to ensure the minions register.  Watch the logs in the other terminal as well for confirmation.
6.  Have fun!  Create any states and pillar files in `salt/state` and `salt/pillar` these directories on the host are mounted as volumes in the master container for ease.


### Volumes
The following directories on the master container are mounted locally for ease of use under the `salt` directory in this repo once the containers are running. See the `docker-compose.yaml` for more info:
- `/etc/salt`
- `/srv/salt`
- `/srv/pillar`
- `/var/cache/salt`

### Cleanup
To cleanup all the images, containers and volumes quickly when you are done (this WILL destroy all data except your salt states and pillar (in `salt/state` and `salt/pillar`) - these are retained.
1. `make destroy`
2. `make clean-dangling-images`
3. `make-clean-images`

Optionally you can add a `kill-em-all` to the Makefile to call all of these :)

### Other Useful Makefile options
- `clean-all-images` - destroys all the images built during the build process
- `stats` - show container stats
- `cli-minion1`, `cli-minion2` etc - shell access to each minion - see the docker-compose file for details.  Basically 1 and 2 are ubuntu and 3 is a centos minion.
- `show-images` - lists the images used in this lab
- `show-containers` - lists the containers used in this lab