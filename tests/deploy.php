<?php

namespace Deployer;

require 'recipe/common.php';

set('ssh_type', 'native');
set('ssh_multiplexing', true);
set('repository', 'https://github.com/musps/test-travis-cache');

host('server1')
  ->stage('test')
  ->hostname(getenv('SERVER1_HOSTNAME'))
  ->port(22)
  ->user(getenv('SERVER1_USER'))
  ->set('deploy_path', '/test')
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