#!/usr/bin/env python
# encoding: utf-8

from setuptools import setup, find_packages
project_name = "project_name"


setup(name=project_name,
      version='1.0.0',
      description="Your project description",
      author="Joe Blow",
      author_email="joe@example.com",
      packages=find_packages(),
      license='proprietary',
      package_dir={project_name: project_name},
      install_requires=[
          'gunicorn',
          'tornado',
          'psycopg2',
          'usethis-django-bootstrap',
      ],
      )
