# ReadyForAction

## Running the demo
Simply run the ```run_demo.py``` script, which will handle refreshing the dependent dockerfile + making some demo specific changes to it. It will then build the image and start the container.

UI will then be available at: http://localhost:61773/csp/user/DemoUI.html

## Development Notes

### UI Files

Use the following to move UI files while developing
```
docker exec -it -u root readyforaction-iris-1 cp -r /irisdev/app/src/UI/. /usr/irissys/csp/broker/
```