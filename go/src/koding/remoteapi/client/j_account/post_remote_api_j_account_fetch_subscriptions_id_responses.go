package j_account

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"fmt"
	"io"

	"github.com/go-openapi/runtime"

	strfmt "github.com/go-openapi/strfmt"

	"koding/remoteapi/models"
)

// PostRemoteAPIJAccountFetchSubscriptionsIDReader is a Reader for the PostRemoteAPIJAccountFetchSubscriptionsID structure.
type PostRemoteAPIJAccountFetchSubscriptionsIDReader struct {
	formats strfmt.Registry
}

// ReadResponse reads a server response into the received o.
func (o *PostRemoteAPIJAccountFetchSubscriptionsIDReader) ReadResponse(response runtime.ClientResponse, consumer runtime.Consumer) (interface{}, error) {
	switch response.Code() {

	case 200:
		result := NewPostRemoteAPIJAccountFetchSubscriptionsIDOK()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return result, nil

	default:
		return nil, runtime.NewAPIError("unknown error", response, response.Code())
	}
}

// NewPostRemoteAPIJAccountFetchSubscriptionsIDOK creates a PostRemoteAPIJAccountFetchSubscriptionsIDOK with default headers values
func NewPostRemoteAPIJAccountFetchSubscriptionsIDOK() *PostRemoteAPIJAccountFetchSubscriptionsIDOK {
	return &PostRemoteAPIJAccountFetchSubscriptionsIDOK{}
}

/*PostRemoteAPIJAccountFetchSubscriptionsIDOK handles this case with default header values.

OK
*/
type PostRemoteAPIJAccountFetchSubscriptionsIDOK struct {
	Payload *models.JAccount
}

func (o *PostRemoteAPIJAccountFetchSubscriptionsIDOK) Error() string {
	return fmt.Sprintf("[POST /remote.api/JAccount.fetchSubscriptions/{id}][%d] postRemoteApiJAccountFetchSubscriptionsIdOK  %+v", 200, o.Payload)
}

func (o *PostRemoteAPIJAccountFetchSubscriptionsIDOK) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	o.Payload = new(models.JAccount)

	// response payload
	if err := consumer.Consume(response.Body(), o.Payload); err != nil && err != io.EOF {
		return err
	}

	return nil
}