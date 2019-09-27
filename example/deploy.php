<?php

namespace Deployer;

require 'recipe/common.php';

set('ssh_type', 'native');
set('ssh_multiplexing', true);
set('repository', getenv('CONFIG_GIT');

host('prod')
  ->hostname(getenv('CONFIG_HOSTNAME'))
  ->user(getenv('CONFIG_USER'))
  ->set('deploy_path', getenv('CONFIG_DEPLOY_PATH'))
  ->forwardAgent();

task('deploy', [
    'deploy:prepare',
    'deploy:lock',
    'deploy:release',
    'deploy:clear_paths',
    'deploy:symlink',
    'deploy:unlock',
    'cleanup',
    'success'
]);

after('deploy:failed', 'deploy:unlock');
