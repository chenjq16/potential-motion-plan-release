docker build -t potential-motion-plan-release .
docker run -it --name pmp --gpus all potential-motion-plan-release /bin/bash
docker run -it --name pmp --gpus all -v C:\Users\chenj\Documents\GitHub\potential-motion-plan-release:/potential-motion-plan-release potential-motion-plan-release /bin/bash