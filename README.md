# scipm.exec

scipm.exec is a [scipm](https://github.com/aminassian/scipm) package

## install

```
cd myScipmProject
npm install scipm.exec --save
scipm build
# restart SciTE
```

## why

If WIN then os.execute() flashing black box.
scipm_exec use scitedebug ``spawner-ex``.

## usage

```
local resultExec = scipm.exec("echo helloWorld")
if resultExec.code == 0 then
    print(resultExec.content)
end
```

## dll et so

see file ``lib/README.md``

