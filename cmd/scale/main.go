package main

import (
	"context"
	"fmt"

	"k8s.io/apimachinery/pkg/apis/meta/v1/unstructured"

	ctrl "sigs.k8s.io/controller-runtime"
	"sigs.k8s.io/controller-runtime/pkg/client"
)

func main() {
	config := ctrl.GetConfigOrDie()
	c, err := client.New(config, client.Options{})
	if err != nil {
		panic(err.Error())
	}

	obj := &unstructured.Unstructured{
		Object: map[string]interface{}{
			"apiVersion": "subnetes.ensure-stack.org/v1alpha1",
			"kind":       "Thing",
			"metadata": map[string]interface{}{
				"generateName": "fooo-",
			},
			"spec": map[string]interface{}{
				"displayName": "fooooooo",
			},
		},
	}

	for i := 0; i < 1000; i++ {
		fffffff := obj.DeepCopy()
		err := c.Create(context.TODO(), fffffff)
		if err != nil {
			panic(err)
		}
		fmt.Println(i, fffffff.GetName())
	}
}
