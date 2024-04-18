package module

import (
	"os"
	"strings"
	"text/template"

	"github.com/AlecAivazis/survey/v2"
	"github.com/vinoMamba/pharos/config"
	"github.com/vinoMamba/pharos/tpl"
	"golang.org/x/text/cases"
	"golang.org/x/text/language"
)

type Module struct {
	Name       string
	ModuleName string
}

func NewModule(args []string) *Module {
	var path string
	if len(args) == 0 {
		err := survey.AskOne(&survey.Input{
			Message: "What is the name of the module?",
		}, &path,
			survey.WithValidator(survey.Required),
		)
		if err != nil {
			return nil
		}
	} else {
		path = args[0]
	}
	path = strings.TrimSpace(path)

	if path == "" {
		os.Exit(1)
	}

	fileName := strings.Split(path, "/")[len(strings.Split(path, "/"))-1]

	moduleName := cases.Title(language.Dutch).String(fileName)

	return &Module{
		Name:       path,
		ModuleName: moduleName,
	}
}

func (m *Module) Create() error {
	overwrite := false
	modulePath := config.ModulePath + m.Name
	f, err := os.Stat(modulePath)
	if err == nil && f.IsDir() {
		err := survey.AskOne(&survey.Confirm{
			Message: "The module already exists, do you want to overwrite it?",
		}, &overwrite, survey.WithValidator(survey.Required))
		if err != nil {
			return err
		}
	}

	if !overwrite && err == nil {
		os.Exit(1)
	}

	if overwrite {
		if err := os.RemoveAll(modulePath); err != nil {
			return err
		}
	}

	if err := os.MkdirAll(modulePath, os.ModePerm); err != nil {
		return err
	}
	files, err := tpl.CreateModuleFs.ReadDir("module")

	if err != nil {
		return err
	}

	for _, file := range files {
		fileName := strings.TrimSuffix(file.Name(), ".tpl")
		if fileName == "modal.tsx" {
			fileName = m.ModuleName + "Modal.tsx"
		}
		f, err := os.Create(modulePath + "/" + fileName)
		if err != nil {
			return err
		}
		defer f.Close()
		t, err := template.ParseFS(tpl.CreateModuleFs, "module/"+file.Name())

		if err != nil {
			return err
		}

		if err := t.Execute(f, m); err != nil {
			return err
		}
	}
	return nil
}
