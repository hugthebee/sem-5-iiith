from setuptools import setup, find_packages

setup (
    packages = find_packages(),
    python_requires=">=3.10",
    install_requires=['numpy', 'matplotlib', 'pygame'],   
)