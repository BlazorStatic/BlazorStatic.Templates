# BlazorStatic.Templates

Templates for `dotnet new`

## Long time no see actions - aka how it works

- When BlazorStatic new version is creater one has to run the manual action that will build itself, test a little bit and eventually push to nuget
- Every day the second action runs to refresh BlazorStatic.MinimalBlog with whatever change might happen here. Just check it's not dead.

## Updates

- Time to time an update has to be made to keep the templates fresh. For thes run

```sh
pwsh pack_and_test.ps1
```

That will try to run the template and build the project - so you know if it's valid or not.
