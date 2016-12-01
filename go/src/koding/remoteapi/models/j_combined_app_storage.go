package models

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	strfmt "github.com/go-openapi/strfmt"

	"github.com/go-openapi/errors"
)

// JCombinedAppStorage j combined app storage
// swagger:model JCombinedAppStorage
type JCombinedAppStorage struct {

	// account Id
	AccountID string `json:"accountId,omitempty"`

	// bucket
	Bucket interface{} `json:"bucket,omitempty"`
}

// Validate validates this j combined app storage
func (m *JCombinedAppStorage) Validate(formats strfmt.Registry) error {
	var res []error

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}