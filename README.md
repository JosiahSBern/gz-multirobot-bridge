# gz-multirobot-bridge

Standalone project: dynamic `ros_gz_bridge` discovery + consistent namespacing for multi-robot
Gazebo (Harmonic) simulation, demoed in a warehouse with Kiva-style drive units.

## Quickstart (Linux host)
    xhost +local:docker
    docker compose build
    docker compose run --rm dev            # NVIDIA: docker compose --profile gpu run --rm dev-gpu
    # inside the container
    gz sim worlds/aws_small_warehouse.sdf  # or worlds/amazon_warehouse.sdf
    # second shell: docker compose exec dev bash
    ./tools/spawn_three.sh aws_small_warehouse

## Layout
    docker/ docker-compose.yml   dev environment
    models/amr_drive_unit        robot (unmodified SDF, global topics on purpose)
    models/inventory_pod         drive-under pod
    worlds/                      amazon_warehouse.sdf (generated), aws_small_warehouse.sdf
    third_party/aws_small_warehouse   MIT-0 assets from AWS RoboMaker (see its README)
    tools/                       gen_world.py, spawn_three.sh
