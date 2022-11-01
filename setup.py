#!/usr/bin/python3
# coding:utf-8
from setuptools import setup

setup(
    name='patchup',
    version='0.1',
    py_modules=['patchup'],
    install_requires=[
        'Click',
    ],
    entry_points='''
        [console_scripts]
        patchup=patchup:patchup
    ''',
)
