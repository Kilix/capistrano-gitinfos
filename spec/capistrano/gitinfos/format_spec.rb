require 'spec_helper'
require 'capistrano/gitinfos/format'

describe 'GitInfos Format' do
    infos = {
        'version' => 'v0.35.2-253-gf5c8c09',
        'abbrev_commit' => 'f5c8c09',
        'full_commit' => 'f5c8c0923b1d889446688adafa9103f4629af86f',
        'commit_date' => '2016-04-07T12:43:55+0000',
        'commit_timestamp' => '1460033035',
        'deploy_date' => '2016-04-07T13:15:31+0000',
        'deploy_timestamp' => '1460034931',
    }

    describe 'YAML' do
        it 'format git commit infos to YAML' do
            expected = <<-OUT
---
version: 'v0.35.2-253-gf5c8c09'
abbrev_commit: 'f5c8c09'
full_commit: 'f5c8c0923b1d889446688adafa9103f4629af86f'
commit_date: '2016-04-07T12:43:55+0000'
commit_timestamp: '1460033035'
deploy_date: '2016-04-07T13:15:31+0000'
deploy_timestamp: '1460034931'
OUT

            expect(Capistrano::Gitinfos.format(infos,'yml')).to eq(expected)
        end

        it 'format git commit infos to YAML with empty string section' do
            expected = <<-OUT
---
version: 'v0.35.2-253-gf5c8c09'
abbrev_commit: 'f5c8c09'
full_commit: 'f5c8c0923b1d889446688adafa9103f4629af86f'
commit_date: '2016-04-07T12:43:55+0000'
commit_timestamp: '1460033035'
deploy_date: '2016-04-07T13:15:31+0000'
deploy_timestamp: '1460034931'
OUT

            expect(Capistrano::Gitinfos.format(infos,'yml','')).to eq(expected)
        end

        it 'format git commit infos to YAML with single section' do
            expected = <<-OUT
---
git:
  version: 'v0.35.2-253-gf5c8c09'
  abbrev_commit: 'f5c8c09'
  full_commit: 'f5c8c0923b1d889446688adafa9103f4629af86f'
  commit_date: '2016-04-07T12:43:55+0000'
  commit_timestamp: '1460033035'
  deploy_date: '2016-04-07T13:15:31+0000'
  deploy_timestamp: '1460034931'
OUT

            expect(Capistrano::Gitinfos.format(infos,'yml','git')).to eq(expected)
        end

        it 'format git commit infos to YAML with compound section' do
            expected = <<-OUT
---
git:
  commit:
    infos:
      version: 'v0.35.2-253-gf5c8c09'
      abbrev_commit: 'f5c8c09'
      full_commit: 'f5c8c0923b1d889446688adafa9103f4629af86f'
      commit_date: '2016-04-07T12:43:55+0000'
      commit_timestamp: '1460033035'
      deploy_date: '2016-04-07T13:15:31+0000'
      deploy_timestamp: '1460034931'
OUT

            expect(Capistrano::Gitinfos.format(infos,'yml','git.commit.infos')).to eq(expected)
        end
    end

    describe 'XML' do
        it 'format git commit infos to XML with default app_version tag' do
            expected = <<-OUT
<?xml version="1.0"?>
<app_version>
  <version>v0.35.2-253-gf5c8c09</version>
  <abbrev_commit>f5c8c09</abbrev_commit>
  <full_commit>f5c8c0923b1d889446688adafa9103f4629af86f</full_commit>
  <commit_date>2016-04-07T12:43:55+0000</commit_date>
  <commit_timestamp>1460033035</commit_timestamp>
  <deploy_date>2016-04-07T13:15:31+0000</deploy_date>
  <deploy_timestamp>1460034931</deploy_timestamp>
</app_version>
OUT

            expect(Capistrano::Gitinfos.format(infos,'xml')).to eq(expected)
        end

        it 'format git commit infos to XML with empty section string' do
            expected = <<-OUT
<?xml version="1.0"?>
<app_version>
  <version>v0.35.2-253-gf5c8c09</version>
  <abbrev_commit>f5c8c09</abbrev_commit>
  <full_commit>f5c8c0923b1d889446688adafa9103f4629af86f</full_commit>
  <commit_date>2016-04-07T12:43:55+0000</commit_date>
  <commit_timestamp>1460033035</commit_timestamp>
  <deploy_date>2016-04-07T13:15:31+0000</deploy_date>
  <deploy_timestamp>1460034931</deploy_timestamp>
</app_version>
OUT

            expect(Capistrano::Gitinfos.format(infos, 'xml', '')).to eq(expected)
        end

        it 'format git commit infos to XML with custom git tag' do
            expected = <<-OUT
<?xml version="1.0"?>
<git>
  <version>v0.35.2-253-gf5c8c09</version>
  <abbrev_commit>f5c8c09</abbrev_commit>
  <full_commit>f5c8c0923b1d889446688adafa9103f4629af86f</full_commit>
  <commit_date>2016-04-07T12:43:55+0000</commit_date>
  <commit_timestamp>1460033035</commit_timestamp>
  <deploy_date>2016-04-07T13:15:31+0000</deploy_date>
  <deploy_timestamp>1460034931</deploy_timestamp>
</git>
OUT
            expect(Capistrano::Gitinfos.format(infos, 'xml', 'git')).to eq(expected)
        end

        it 'format git commit infos to XML with compound section' do
            expected = <<-OUT
<?xml version="1.0"?>
<git>
  <commit>
    <infos>
      <version>v0.35.2-253-gf5c8c09</version>
      <abbrev_commit>f5c8c09</abbrev_commit>
      <full_commit>f5c8c0923b1d889446688adafa9103f4629af86f</full_commit>
      <commit_date>2016-04-07T12:43:55+0000</commit_date>
      <commit_timestamp>1460033035</commit_timestamp>
      <deploy_date>2016-04-07T13:15:31+0000</deploy_date>
      <deploy_timestamp>1460034931</deploy_timestamp>
    </infos>
  </commit>
</git>
OUT
            expect(Capistrano::Gitinfos.format(infos, 'xml', 'git.commit.infos')).to eq(expected)
        end
    end

    describe 'INI' do
        it 'format git commit infos to INI with default app_version section' do
            expected = <<-OUT
[app_version]
version = v0.35.2-253-gf5c8c09
abbrev_commit = f5c8c09
full_commit = f5c8c0923b1d889446688adafa9103f4629af86f
commit_date = 2016-04-07T12:43:55+0000
commit_timestamp = 1460033035
deploy_date = 2016-04-07T13:15:31+0000
deploy_timestamp = 1460034931
OUT

            expect(Capistrano::Gitinfos.format(infos,'ini')).to eq(expected)
        end

        it 'format git commit infos to INI with empty string section' do
            expected = <<-OUT
[app_version]
version = v0.35.2-253-gf5c8c09
abbrev_commit = f5c8c09
full_commit = f5c8c0923b1d889446688adafa9103f4629af86f
commit_date = 2016-04-07T12:43:55+0000
commit_timestamp = 1460033035
deploy_date = 2016-04-07T13:15:31+0000
deploy_timestamp = 1460034931
OUT

            expect(Capistrano::Gitinfos.format(infos,'ini', '')).to eq(expected)
        end

        it 'format git commit infos to INI with git section' do
            expected = <<-OUT
[git]
version = v0.35.2-253-gf5c8c09
abbrev_commit = f5c8c09
full_commit = f5c8c0923b1d889446688adafa9103f4629af86f
commit_date = 2016-04-07T12:43:55+0000
commit_timestamp = 1460033035
deploy_date = 2016-04-07T13:15:31+0000
deploy_timestamp = 1460034931
OUT

            expect(Capistrano::Gitinfos.format(infos,'ini','git')).to eq(expected)
        end

        it 'format git commit infos to INI with compound section' do
            expected = <<-OUT
[git.commit.infos]
version = v0.35.2-253-gf5c8c09
abbrev_commit = f5c8c09
full_commit = f5c8c0923b1d889446688adafa9103f4629af86f
commit_date = 2016-04-07T12:43:55+0000
commit_timestamp = 1460033035
deploy_date = 2016-04-07T13:15:31+0000
deploy_timestamp = 1460034931
OUT

            expect(Capistrano::Gitinfos.format(infos,'ini','git.commit.infos')).to eq(expected)
        end
    end

    describe 'JSON' do
        it 'format git commit infos to JSON' do
            expected = <<-OUT
{
  "version": "v0.35.2-253-gf5c8c09",
  "abbrev_commit": "f5c8c09",
  "full_commit": "f5c8c0923b1d889446688adafa9103f4629af86f",
  "commit_date": "2016-04-07T12:43:55+0000",
  "commit_timestamp": "1460033035",
  "deploy_date": "2016-04-07T13:15:31+0000",
  "deploy_timestamp": "1460034931"
}
OUT

            expect(Capistrano::Gitinfos.format(infos,'json')).to eq(expected)
        end

        it 'format git commit infos to JSON with empty string section' do
            expected = <<-OUT
{
  "version": "v0.35.2-253-gf5c8c09",
  "abbrev_commit": "f5c8c09",
  "full_commit": "f5c8c0923b1d889446688adafa9103f4629af86f",
  "commit_date": "2016-04-07T12:43:55+0000",
  "commit_timestamp": "1460033035",
  "deploy_date": "2016-04-07T13:15:31+0000",
  "deploy_timestamp": "1460034931"
}
OUT

            expect(Capistrano::Gitinfos.format(infos,'json','')).to eq(expected)
        end

        it 'format git commit infos to JSON with single section' do
            expected = <<-OUT
{
  "git": {
    "version": "v0.35.2-253-gf5c8c09",
    "abbrev_commit": "f5c8c09",
    "full_commit": "f5c8c0923b1d889446688adafa9103f4629af86f",
    "commit_date": "2016-04-07T12:43:55+0000",
    "commit_timestamp": "1460033035",
    "deploy_date": "2016-04-07T13:15:31+0000",
    "deploy_timestamp": "1460034931"
  }
}
OUT

            expect(Capistrano::Gitinfos.format(infos,'json','git')).to eq(expected)
        end

        it 'format git commit infos to JSON with compound section' do
            expected = <<-OUT
{
  "git": {
    "commit": {
      "infos": {
        "version": "v0.35.2-253-gf5c8c09",
        "abbrev_commit": "f5c8c09",
        "full_commit": "f5c8c0923b1d889446688adafa9103f4629af86f",
        "commit_date": "2016-04-07T12:43:55+0000",
        "commit_timestamp": "1460033035",
        "deploy_date": "2016-04-07T13:15:31+0000",
        "deploy_timestamp": "1460034931"
      }
    }
  }
}
OUT

            expect(Capistrano::Gitinfos.format(infos,'json','git.commit.infos')).to eq(expected)
        end
    end
end
