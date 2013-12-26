# UniMRCP cookbook

This Chef cookbook installs UniMRCP from source and configures its basic settings.

# Requirements

Tested on Ubuntu 12.04 and Debian 7.1.

# Usage

Add `recipe[unimrcp]` to your node's run list.

# Attributes

* `node['unimrcp']['version']` - the version of UniMRCP to install (default `1.1.0`)
* `node['unimrcp']['packages'] - the UniMRCP package dependencies to install (default %w{pkg-config build-essential}`)
* `node['unimrcp']['install_dir']` - the directory in which to install UniMRCP (default `/usr/local/unimrcp`)

# Recipes

* `unimrcp` - Fetches and installs UniMRCP

# Author

[Ben Langfeld](@benlangfeld)
