/*
Copyright © 2024 Vino <vino0908@outlook.com>
*/
package cmd

import (
	"github.com/spf13/cobra"
)

// addCmd represents the add command
var addCmd = &cobra.Command{
	Use:     "add",
	Example: "pharos add module <module-name>",
	Short:   "add a component or a module to the project",
}

func init() {
	rootCmd.AddCommand(addCmd)
}
