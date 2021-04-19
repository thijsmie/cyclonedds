# -- Project information -----------------------------------------------------

project = 'CycloneDDS'
copyright = '2021, CycloneDDS committers'
author = 'CycloneDDS committers'

# The short X.Y version
version = '0.7.0'

# The full version, including alpha/beta/rc tags
release = '0.7.0'


# -- General configuration ---------------------------------------------------

extensions = [
    "breathe",
    "exhale",
    "sphinx.ext.intersphinx",
    "sphinx.ext.viewcode",
    "sphinx.ext.autosummary"
]

templates_path = ['_templates']
language = 'en'
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']


# -- Options for HTML output -------------------------------------------------

try:
    import sphinx_rtd_theme
    extensions.append('sphinx_rtd_theme')
    html_theme = 'sphinx_rtd_theme'
except ImportError:
    import warnings
    warnings.warn("The Sphinx rtd theme is not installed. Falling back to alabaster.")
    html_theme = 'alabaster'


html_static_path = ['_static']

autosummary_generate=True
# Setup the exhale extension
exhale_args = {
    "containmentFolder":     "./ddsc_api_docs",
    "rootFileName":          "library_root.rst",
    "rootFileTitle":         "Eclipse Cyclone DDS C API Reference",
    "doxygenStripFromPath":  "..",
    "fullToctreeMaxDepth":   1,
    "createTreeView":        True,
    "exhaleExecutesDoxygen": True,
    "exhaleUseDoxyfile": True
}

# Tell sphinx what the primary language being documented is.
primary_domain = 'c'

# Tell sphinx what the pygments highlight language should be.
highlight_language = 'c'

breathe_projects = { "ddsc_api_docs": "./xml" }
breathe_default_project = 'ddsc_api_docs'