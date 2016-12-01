package models

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	strfmt "github.com/go-openapi/strfmt"
	"github.com/go-openapi/swag"

	"github.com/go-openapi/errors"
	"github.com/go-openapi/validate"
)

// JTag j tag
// swagger:model JTag
type JTag struct {

	// body
	Body string `json:"body,omitempty"`

	// category
	Category string `json:"category,omitempty"`

	// counts
	Counts *JTagCounts `json:"counts,omitempty"`

	// group
	Group string `json:"group,omitempty"`

	// meta
	Meta interface{} `json:"meta,omitempty"`

	// slug
	Slug string `json:"slug,omitempty"`

	// status
	Status string `json:"status,omitempty"`

	// synonyms
	Synonyms []string `json:"synonyms"`

	// title
	// Required: true
	Title *string `json:"title"`
}

// Validate validates this j tag
func (m *JTag) Validate(formats strfmt.Registry) error {
	var res []error

	if err := m.validateCounts(formats); err != nil {
		// prop
		res = append(res, err)
	}

	if err := m.validateSynonyms(formats); err != nil {
		// prop
		res = append(res, err)
	}

	if err := m.validateTitle(formats); err != nil {
		// prop
		res = append(res, err)
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}

func (m *JTag) validateCounts(formats strfmt.Registry) error {

	if swag.IsZero(m.Counts) { // not required
		return nil
	}

	if m.Counts != nil {

		if err := m.Counts.Validate(formats); err != nil {
			return err
		}
	}

	return nil
}

func (m *JTag) validateSynonyms(formats strfmt.Registry) error {

	if swag.IsZero(m.Synonyms) { // not required
		return nil
	}

	return nil
}

func (m *JTag) validateTitle(formats strfmt.Registry) error {

	if err := validate.Required("title", "body", m.Title); err != nil {
		return err
	}

	return nil
}

// JTagCounts j tag counts
// swagger:model JTagCounts
type JTagCounts struct {

	// followers
	Followers float64 `json:"followers,omitempty"`

	// following
	Following float64 `json:"following,omitempty"`

	// tagged
	Tagged float64 `json:"tagged,omitempty"`
}

// Validate validates this j tag counts
func (m *JTagCounts) Validate(formats strfmt.Registry) error {
	var res []error

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}