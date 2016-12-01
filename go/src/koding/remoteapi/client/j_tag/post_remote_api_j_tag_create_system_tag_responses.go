package j_tag

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"fmt"
	"io"

	"github.com/go-openapi/runtime"

	strfmt "github.com/go-openapi/strfmt"

	"koding/remoteapi/models"
)

// PostRemoteAPIJTagCreateSystemTagReader is a Reader for the PostRemoteAPIJTagCreateSystemTag structure.
type PostRemoteAPIJTagCreateSystemTagReader struct {
	formats strfmt.Registry
}

// ReadResponse reads a server response into the received o.
func (o *PostRemoteAPIJTagCreateSystemTagReader) ReadResponse(response runtime.ClientResponse, consumer runtime.Consumer) (interface{}, error) {
	switch response.Code() {

	case 200:
		result := NewPostRemoteAPIJTagCreateSystemTagOK()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return result, nil

	case 401:
		result := NewPostRemoteAPIJTagCreateSystemTagUnauthorized()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return nil, result

	default:
		return nil, runtime.NewAPIError("unknown error", response, response.Code())
	}
}

// NewPostRemoteAPIJTagCreateSystemTagOK creates a PostRemoteAPIJTagCreateSystemTagOK with default headers values
func NewPostRemoteAPIJTagCreateSystemTagOK() *PostRemoteAPIJTagCreateSystemTagOK {
	return &PostRemoteAPIJTagCreateSystemTagOK{}
}

/*PostRemoteAPIJTagCreateSystemTagOK handles this case with default header values.

Request processed succesfully
*/
type PostRemoteAPIJTagCreateSystemTagOK struct {
	Payload *models.DefaultResponse
}

func (o *PostRemoteAPIJTagCreateSystemTagOK) Error() string {
	return fmt.Sprintf("[POST /remote.api/JTag.createSystemTag][%d] postRemoteApiJTagCreateSystemTagOK  %+v", 200, o.Payload)
}

func (o *PostRemoteAPIJTagCreateSystemTagOK) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	o.Payload = new(models.DefaultResponse)

	// response payload
	if err := consumer.Consume(response.Body(), o.Payload); err != nil && err != io.EOF {
		return err
	}

	return nil
}

// NewPostRemoteAPIJTagCreateSystemTagUnauthorized creates a PostRemoteAPIJTagCreateSystemTagUnauthorized with default headers values
func NewPostRemoteAPIJTagCreateSystemTagUnauthorized() *PostRemoteAPIJTagCreateSystemTagUnauthorized {
	return &PostRemoteAPIJTagCreateSystemTagUnauthorized{}
}

/*PostRemoteAPIJTagCreateSystemTagUnauthorized handles this case with default header values.

Unauthorized request
*/
type PostRemoteAPIJTagCreateSystemTagUnauthorized struct {
	Payload *models.UnauthorizedRequest
}

func (o *PostRemoteAPIJTagCreateSystemTagUnauthorized) Error() string {
	return fmt.Sprintf("[POST /remote.api/JTag.createSystemTag][%d] postRemoteApiJTagCreateSystemTagUnauthorized  %+v", 401, o.Payload)
}

func (o *PostRemoteAPIJTagCreateSystemTagUnauthorized) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	o.Payload = new(models.UnauthorizedRequest)

	// response payload
	if err := consumer.Consume(response.Body(), o.Payload); err != nil && err != io.EOF {
		return err
	}

	return nil
}