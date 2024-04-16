package tpl

import "embed"

//go:embed module/*.tpl
var CreateModuleFs embed.FS

//go:embed api/*.tpl
var CreateApiFs embed.FS
