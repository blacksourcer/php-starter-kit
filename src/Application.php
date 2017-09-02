<?php

namespace Project;

/**
 * Class Application
 *
 * @package Project
 */
class Application
{
    public function run(): bool
    {
        return phpinfo();
    }
}
