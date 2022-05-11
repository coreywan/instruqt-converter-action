# instruqt-converter-action

Github Action to convert Instruqt (<https://www.instruqt.com>) tracks to and from a temporary state as part of a pipeline.  This tool utilizes the instruqt-converter utility found at <https://github.com/nsthompson/instruqt-converter>

## Usage

```yaml
on:
  pull_request:
    types:
      - closed
    branches:
      - develop
    paths-ignore:
      - 'README.md'
  workflow_dispatch:
    inputs:
      run-manually:
        required: true
        type: boolean
        description: Run Job Manually

jobs:
  instruqt-deploy-dev:
    if: |
      github.event.pull_request.merged || 
      github.event.inputs.run-manually == 'true'
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v2

      - name: Install Instruqt
        id: install
        run: |-
          wget https://github.com/instruqt/cli/releases/download/2036-df08c03/instruqt-linux-2036-df08c03.zip -O /tmp/instruqt.zip
          unzip /tmp/instruqt.zip -d /usr/local/bin
          instruqt update

      - name: Validate Track
        id: validate
        env:
          INSTRUQT_TOKEN: ${{ secrets.INSTRUQT_TOKEN }}
        run: |-
          instruqt track validate

      - name: Convert to dev
        uses: nsthompson/instruqt-converter-action@v1.0
        env:
          CONVERT_TO: 'dev'
          # IDENTIFIER: - Use to override default IDENTIFIER of dev
          INSTRUQT_API_KEY: ${{ secrets.INSTRUQT_API_KEY }}
          INSTRUQT_ORG_SLUG: ${{ secrets.INSTRUQT_ORG_SLUG }}
          # INSTRUQT_API_URL: - Use to override default API URL of https://play.instruqt.com/graphql
```

## Configuration

Set the following properties as secrets in your repository under `Settings / Secrets`.

Name | Required | Description
----- | --------- | -----------
INSTRUQT_API_KEY | Yes | Instruqt API Key
INSTRUQT_ORG_SLUG | Yes | Instruqt Org Slug

## License

This project is distributed under the [MIT license](LICENSE.md).

## Contributors

* Nick Thompson ([@nsthompson](https://github.com/nsthompson))
