package j_kite

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"fmt"
	"io"

	"github.com/go-openapi/runtime"

	strfmt "github.com/go-openapi/strfmt"

	"koding/remoteapi/models"
)

// PostRemoteAPIJKiteModifyIDReader is a Reader for the PostRemoteAPIJKiteModifyID structure.
type PostRemoteAPIJKiteModifyIDReader struct {
	formats strfmt.Registry
}

// ReadResponse reads a server response into the received o.
func (o *PostRemoteAPIJKiteModifyIDReader) ReadResponse(response runtime.ClientResponse, consumer runtime.Consumer) (interface{}, error) {
	switch response.Code() {

	case 200:
		result := NewPostRemoteAPIJKiteModifyIDOK()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return result, nil

	default:
		return nil, runtime.NewAPIError("unknown error", response, response.Code())
	}
}

// NewPostRemoteAPIJKiteModifyIDOK creates a PostRemoteAPIJKiteModifyIDOK with default headers values
func NewPostRemoteAPIJKiteModifyIDOK() *PostRemoteAPIJKiteModifyIDOK {
	return &PostRemoteAPIJKiteModifyIDOK{}
}

/*PostRemoteAPIJKiteModifyIDOK handles this case with default header values.

OK
*/
type PostRemoteAPIJKiteModifyIDOK struct {
	Payload *models.JKite
}

func (o *PostRemoteAPIJKiteModifyIDOK) Error() string {
	return fmt.Sprintf("[POST /remote.api/JKite.modify/{id}][%d] postRemoteApiJKiteModifyIdOK  %+v", 200, o.Payload)
}

func (o *PostRemoteAPIJKiteModifyIDOK) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	o.Payload = new(models.JKite)

	// response payload
	if err := consumer.Consume(response.Body(), o.Payload); err != nil && err != io.EOF {
		return err
	}

	return nil
}