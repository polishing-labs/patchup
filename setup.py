#!/usr/bin/python3
# coding:utf-8
'''
  @Author: ZIKH26
  @Date: 2022-03-01 20:59:51
LastEditors: ttimochan
LastEditTime: 2022-11-01 22:18:44
FilePath: /patchup/setup.py
'''
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
