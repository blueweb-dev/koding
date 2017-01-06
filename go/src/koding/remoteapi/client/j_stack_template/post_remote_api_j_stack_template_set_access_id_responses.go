package j_stack_template

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"fmt"
	"io"

	"github.com/go-openapi/errors"
	"github.com/go-openapi/runtime"
	"github.com/go-openapi/swag"

	strfmt "github.com/go-openapi/strfmt"

	"koding/remoteapi/models"
)

// PostRemoteAPIJStackTemplateSetAccessIDReader is a Reader for the PostRemoteAPIJStackTemplateSetAccessID structure.
type PostRemoteAPIJStackTemplateSetAccessIDReader struct {
	formats strfmt.Registry
}

// ReadResponse reads a server response into the received o.
func (o *PostRemoteAPIJStackTemplateSetAccessIDReader) ReadResponse(response runtime.ClientResponse, consumer runtime.Consumer) (interface{}, error) {
	switch response.Code() {

	case 200:
		result := NewPostRemoteAPIJStackTemplateSetAccessIDOK()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return result, nil

	default:
		return nil, runtime.NewAPIError("unknown error", response, response.Code())
	}
}

// NewPostRemoteAPIJStackTemplateSetAccessIDOK creates a PostRemoteAPIJStackTemplateSetAccessIDOK with default headers values
func NewPostRemoteAPIJStackTemplateSetAccessIDOK() *PostRemoteAPIJStackTemplateSetAccessIDOK {
	return &PostRemoteAPIJStackTemplateSetAccessIDOK{}
}

/*PostRemoteAPIJStackTemplateSetAccessIDOK handles this case with default header values.

OK
*/
type PostRemoteAPIJStackTemplateSetAccessIDOK struct {
	Payload PostRemoteAPIJStackTemplateSetAccessIDOKBody
}

func (o *PostRemoteAPIJStackTemplateSetAccessIDOK) Error() string {
	return fmt.Sprintf("[POST /remote.api/JStackTemplate.setAccess/{id}][%d] postRemoteApiJStackTemplateSetAccessIdOK  %+v", 200, o.Payload)
}

func (o *PostRemoteAPIJStackTemplateSetAccessIDOK) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	// response payload
	if err := consumer.Consume(response.Body(), &o.Payload); err != nil && err != io.EOF {
		return err
	}

	return nil
}

/*PostRemoteAPIJStackTemplateSetAccessIDOKBody post remote API j stack template set access ID o k body
swagger:model PostRemoteAPIJStackTemplateSetAccessIDOKBody
*/
type PostRemoteAPIJStackTemplateSetAccessIDOKBody struct {
	models.JStackTemplate

	models.DefaultResponse
}

// UnmarshalJSON unmarshals this object from a JSON structure
func (o *PostRemoteAPIJStackTemplateSetAccessIDOKBody) UnmarshalJSON(raw []byte) error {

	var postRemoteAPIJStackTemplateSetAccessIDOKBodyAO0 models.JStackTemplate
	if err := swag.ReadJSON(raw, &postRemoteAPIJStackTemplateSetAccessIDOKBodyAO0); err != nil {
		return err
	}
	o.JStackTemplate = postRemoteAPIJStackTemplateSetAccessIDOKBodyAO0

	var postRemoteAPIJStackTemplateSetAccessIDOKBodyAO1 models.DefaultResponse
	if err := swag.ReadJSON(raw, &postRemoteAPIJStackTemplateSetAccessIDOKBodyAO1); err != nil {
		return err
	}
	o.DefaultResponse = postRemoteAPIJStackTemplateSetAccessIDOKBodyAO1

	return nil
}

// MarshalJSON marshals this object to a JSON structure
func (o PostRemoteAPIJStackTemplateSetAccessIDOKBody) MarshalJSON() ([]byte, error) {
	var _parts [][]byte

	postRemoteAPIJStackTemplateSetAccessIDOKBodyAO0, err := swag.WriteJSON(o.JStackTemplate)
	if err != nil {
		return nil, err
	}
	_parts = append(_parts, postRemoteAPIJStackTemplateSetAccessIDOKBodyAO0)

	postRemoteAPIJStackTemplateSetAccessIDOKBodyAO1, err := swag.WriteJSON(o.DefaultResponse)
	if err != nil {
		return nil, err
	}
	_parts = append(_parts, postRemoteAPIJStackTemplateSetAccessIDOKBodyAO1)

	return swag.ConcatJSON(_parts...), nil
}

// Validate validates this post remote API j stack template set access ID o k body
func (o *PostRemoteAPIJStackTemplateSetAccessIDOKBody) Validate(formats strfmt.Registry) error {
	var res []error

	if err := o.JStackTemplate.Validate(formats); err != nil {
		res = append(res, err)
	}

	if err := o.DefaultResponse.Validate(formats); err != nil {
		res = append(res, err)
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}
