# Automated Pynguin Test Runs
​	This repository is made as a template for producing Pynguin tests using organized, automated outputs.

​	It is recommended that one use Linux, a Linux VM, or WSL for all Pynguin work. For the bash script, that is required to utilize it. You will also need Docker in order to use the automated Pynguin bash script.



## Setting Up Automated Testing

The following is a quick setup guide to using the `run_pynguin.sh` bash script for automated test runs.



### Creating Your Docker Image

​	Firstly, you need to build the docker image that will be used to run the file. There is a Dockerfile provided in this repo as well as one provided by the Pynguin team on their github. Feel free to experiment with the dockerfile as needed.

​	To build, run the following command from the directory containing the Dockerfile:

```bash
docker build -t pynguin-docker-img .
```

(You may change the name of the docker image, but you will need to change the name in the `run_pynguin.sh` bash script on line 12.)



### Running The Bash Script

​	First, you may need to give yourself access to the script. To do so, run the following command to give yourself executable permissions:

```bash
chmod +x run_pynguin.sh
```

​	Now, you can run the script assuming (1) Docker Engine is Running, (2) your Docker image has been built and properly tagged, (3)  you have code that is ready to be tested in the input directory.

​	Run the script using the following command:

```bash
./run_pynguin.sh <num_iterations> <input_path> <output_path> <package_path> <module_name> (optional <path/to/params.txt>)
```

`<num_iterations>` - The number of times you want the script to run Pynguin and produce results. Each test module will be output with its particular iteration appended to the name. (For example, running Pynguin on a module named "lib" three times will output: `test_lib0.py`, `test_lib1.py`, `test_lib2.py`)

`<input_path>` - Path to the module you are testing. Looks like `path/to/module/` and does *not* include the module itself, only its current directory.

`<output_path>` - Path to the output where Pynguin puts its generated tests. Recommended to used `output/`. If you have subfolders in output, append those to the directory as needed.

`<package_path>` - Path to the `package.txt` file used by the Docker container for dependencies. Can also hold the params.txt file. By default, use `package/`.

`<module_name>` - The name of the module being tests. If the module is named `lib.py`, simply put `lib` without the ".py" file extension.

`<path/to/params.txt>` - Optional parameter. The path to the parameter.txt file containing line delineated Pynguin parameters. The .txt file can be any name, allowing custom, flexible naming of preset parameters. If the file is called `params.txt` and is in the `package/` directory, use `package/params.txt`
