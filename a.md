    docker build -t potential-motion-plan-release .
    docker run -it --name pmp --gpus all potential-motion-plan-release /bin/bash
    docker run -it --name pmp --gpus all -v C:\Users\chenj\Documents\GitHub\potential-motion-plan-release:/potential-motion-plan-release potential-motion-plan-release /bin/bash

    source activate pb_diff
    pip install -r requirements.txt
    cd pb_diff_envs && pip install -e . && cd ..

    unzip model-dualkuka-base.zip -d .
    unzip model-kuka-base.zip -d .
    unzip model-maze2d-concave-base.zip -d .
    unzip model-maze2d-dynamic-base -d .
    unzip model-maze2d-static1-base.zip -d .
    unzip model-maze2d-static2-base.zip -d .

    cd pb_diff_envs/pb_diff_envs
    unzip dualkuka14d-base.zip -d .
    unzip kuka7d-base.zip -d .
    unzip maze2d-concave-base.zip -d .
    unzip maze2d-dyanmic-base.zip -d .
    unzip maze2d-static1-base.zip -d .
    unzip maze2d-static2-base.zip -d .
    unzip rm2d-comp.zip -d .
    cd ../..

    export PYTHONPATH=$(pwd)/pb_diff_envs:$PYTHONPATH

    // install uvx
    wget -qO- https://astral.sh/uv/install.sh | sh
    uvx nvitop