# StoryLayers

This project creates and uploads an AWS Lambda Layer for story analysis using docker following reference 1.

1. To create/upload a "Story Layer" create the following folder structure in the project directory.

    ```sh
    StoryLayers
        | python
            |lib
                | python3.8
                    |site-packages
    ```

2. Execute the installation script as follows:

    ```sh
    ./scripts/install.sh -p 3.8 -u yes -l StoryLayer
    ```

3. Copy "LayerVersionArn" and use it in the SAM template.yml for specific AWS Lambda.

Note: You should have docker and aws-cli installed locally before following these steps.

References:

1. [How do I create a Lambda layer using a simulated Lambda environment with Docker?](https://aws.amazon.com/premiumsupport/knowledge-center/lambda-layer-simulated-docker/)
