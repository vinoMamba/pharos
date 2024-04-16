package api

import (
	"fmt"
	"os"
	"strings"
	"text/template"

	"github.com/AlecAivazis/survey/v2"
	"github.com/vinoMamba/pharos/config"
	"github.com/vinoMamba/pharos/tpl"
	"golang.org/x/text/cases"
	"golang.org/x/text/language"
)

type Api struct {
	Name    string
	ApiName string
}

func NewApi(args []string) *Api {
	var path string
	if len(args) == 0 {
		err := survey.AskOne(&survey.Input{
			Message: "What is the name of the interface?",
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

	fileName := strings.Split(path, "/")[0]

	apiName := cases.Title(language.Dutch).String(fileName)

	return &Api{
		Name:    path,
		ApiName: apiName,
	}
}

func (a *Api) Create() error {
	apiFile := config.ApiPath + a.Name + ".ts"
	f, err := os.Stat(apiFile)
	if err == nil && !f.IsDir() {
		fmt.Println("The interface already exists")
		os.Exit(1)
	}
	file, err := os.Create(apiFile)
	if err != nil {
		return err
	}

	defer file.Close()
	t, err := template.ParseFS(tpl.CreateApiFs, "api/api.tpl")
	if err != nil {
		return err
	}

	if err := t.Execute(file, a); err != nil {
		return err
	}

	return nil
}
