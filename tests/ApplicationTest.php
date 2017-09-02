<?php

namespace Project\Tests;

use PHPUnit\Framework\TestCase as PhpUnitTestCase;
use Project\Application;

/**
 * Class ApplicationTest
 *
 * @package Project\Tests
 */
class ApplicationTest extends PhpUnitTestCase
{
    /**
     * Test if application runs
     */
    public function testRun()
    {
        $application = new Application();

        $this->assertTrue($application->run());
    }
}
