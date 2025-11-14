# BlazorStatic.Templates

Templates for `dotnet new`

[BlazorStatic](https://github.com/BlazorStatic/BlazorStatic/) - Harness the power of Blazor to craft static websites.

## Usage

Install the BlazorStatic templates:

```sh
dotnet new install BlazorStatic.Templates
```

This adds new options to your `dotnet new` template list. Then create a new project using:

```sh
dotnet new BlazorStaticMinimalBlog -o MyBlazorStaticApp
```

You can exclude the default posts with `-e`:

```sh
dotnet new BlazorStaticMinimalBlog -o MyBlazorStaticApp -e
```

## Long time no see actions - aka how the devops around this works

- There is a cron running every day, checking if new version of BlazorStatic appeared
  - no: do nothing
  - yes:
    - get the version and put in to the templates like MinimalBlog
    - increment BlazorStatic.Templates version
    - create PR
  - Once the PR is merged:
    - run pipeline that will update BlazorStatic.Templates nuget
    - create github template for MinimalBlog and push it there

## Updates

- Time to time an update has to be made to keep the templates fresh and nice.

```sh
pwsh pack_and_test.ps1
```

That will try to run the template and build the project - so you know if it's valid or not.
