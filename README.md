# PHPMetrics - Server

PhpMetrics provides metrics about PHP project and classes, with beautiful and readable HTML report.
This server will generate your reports and expose this reports as webpages.

## Getting Started

You can start it by this command:

```
docker run --rm -p 8080:8080 -v ~/code:/var/www/code -d phpmetrics
```

It mounts your code directory, which has your repositories in it and generate reports automatically.

### Prerequisites

What things you need to install the software

[Docker](https://www.docker.com/)

### Installing

A step by step series of examples that tell you have to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).

## Authors

* **André Karrlein** - *Initial work* - [andre-karrlein](https://github.com/andre-karrlein), [@rb_ak1](https://twitter.com/rb_ak1)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Credits

[phpmetrics](https://github.com/phpmetrics/PhpMetrics)
+ Jean-François Lépine <[@Halleck45](https://twitter.com/Halleck45)>
