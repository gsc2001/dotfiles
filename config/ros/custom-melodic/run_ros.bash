
docker run -td \
    -v ~/catkin_ws:/home/user/catkin_ws \
    -v ~/IIIT-Stuff/RRC/rpvio/data:/home/user/data \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --runtime=nvidia \
    --name=rpvio \
    --cap-add sys_ptrace \
    -p127.0.0.1:2222:22 \
    ros:nvidia
